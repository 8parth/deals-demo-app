class AddCompanyDomainToPipedriveTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :pipedrive_tokens, :company_domain, :string
    add_column :pipedrive_tokens, :pipedrive_user_id, :integer
    add_column :pipedrive_tokens, :company_id, :integer
  end
end
