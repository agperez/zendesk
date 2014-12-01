class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]


  def index
    @tickets = Ticket.all
  end

  def refresh
    client.tickets.include(:metric_sets).all do |t|
      solved = t.metric_set.solved_at
      created = t.metric_set.created_at
      product = ""
      closed_time = 0

      if solved
        closed_time = time_diff(created, solved)
      end

      t.custom_fields.each do |c|
        if c.id == 22455799
          product = c.value
        end
      end

      @ticket = Ticket.find_or_initialize_by(zenid: t.id)

      @ticket.update(opened: created, closed: solved,
                     first_assigned: t.metric_set.initially_assigned_at,
                     reply_time: t.metric_set.reply_time_in_minutes.calendar,
                     agent: t.assignee_id, product: product, closed_time: closed_time)
    end
    redirect_to tickets_path
  end

  #@ticket = Ticket.new
  #@ticket.zenid          = t.id
  # @ticket.opened         = created
  # @ticket.closed         = solved
  # @ticket.first_assigned = t.metric_set.initially_assigned_at
  # @ticket.reply_time     = t.metric_set.reply_time_in_minutes.calendar
  # @ticket.assignee       = t.assignee_id
  # if solved
  #   @ticket.closed_time  = time_diff(created, solved)
  # end
  # t.custom_fields.each do |c|
  #   if c.id == 22455799
  #     @ticket.product    = c.value
  #   end
  # end
  # if @ticket.save
  #   redirect_to ticket_path(@ticket)
  # else
  #   redirect_to tickets_path
  # end

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
                                     :reply_time, :product, :agent)
    end
end
