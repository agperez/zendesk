json.array!(@refresh_audits) do |refresh_audit|
  json.extract! refresh_audit, :id, :type, :stamp
  json.url refresh_audit_url(refresh_audit, format: :json)
end
