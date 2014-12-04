class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]


  def index
    @tickets = Ticket.all
  end

  def refresh
    client.tickets.include(:metric_sets).all do |t|
      zenid = t.assignee_id
      if zenid
        @user = User.find_or_create_by(zenid: zenid)
      end
      originally_solved = t.metric_set.solved_at.in_time_zone('Eastern Time (US & Canada)') if t.metric_set.solved_at
      originally_created = t.metric_set.created_at.in_time_zone('Eastern Time (US & Canada)') if t.metric_set.created_at
      solved = business_time(originally_solved) if originally_solved
      created = business_time(originally_created) if originally_created

      product = ""
      closed_time = 0

      if solved and created < solved
        closed_time = closing_time(created, solved)
      end

      t.custom_fields.each do |c|
        if c.id == 22455799
          product = c.value
        end
      end

      first_assigned = t.metric_set.initially_assigned_at.in_time_zone('Eastern Time (US & Canada)') if t.metric_set.initially_assigned_at

      ticket = Ticket.find_or_initialize_by(zenid: t.id)

      ticket.update(opened: created, closed: solved,
                     first_assigned: first_assigned,
                     reply_time: t.metric_set.reply_time_in_minutes.business,
                     agent: t.assignee_id, product: product, closed_time: closed_time,
                     user_id: @user.id, originally_created: originally_created,
                     originally_closed: originally_solved, replies: t.metric_set.replies)
    end
    redirect_to this_month_path
  end

  def this_month
    #Avg Reply Time (Time til first response)
    #Avg Close Time
    #Total nubmer of Prospector Tickets
    @prospector_tix = Ticket.where("opened > ? AND product = ?", Time.now.beginning_of_month, "prospector")
    @cadence_tix    = Ticket.where("opened > ? AND product = ?", Time.now.beginning_of_month, "cadence")

    first_sum = 0
    close_sum = 0
    i=0
    @prospector_tix.each do |t|
      if t.closed_time && t.reply_time
        close_sum += t.closed_time
        first_sum += t.reply_time
        i+=1
      end
    end
    @pro_total_closed = i
    @pro_first_avg = first_sum.to_f / i
    @pro_close_avg = close_sum.to_f / i

    cad_first_sum = 0
    cad_close_sum = 0
    cad_i=0
    @cadence_tix.each do |t|
      if t.closed_time && t.reply_time
        cad_close_sum += t.closed_time
        cad_first_sum += t.reply_time
        cad_i+=1
      end
    end
    @cad_total_closed = cad_i
    @cad_first_avg = cad_first_sum.to_f / cad_i
    @cad_close_avg = cad_close_sum.to_f / cad_i
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:zenid, :opened, :closed, :first_assigned, :closed_time,
                                     :reply_time, :product, :agent, :replies, :user_id)
    end


end
