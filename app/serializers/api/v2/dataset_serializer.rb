class API::V2::DatasetSerializer < ApplicationSerializer
  attributes \
    :id,
    :total_products,
    :total_stores,
    :total_inventories,
    :total_product_inventory_count,
    :total_product_inventory_volume_in_milliliters,
    :total_product_inventory_price_in_cents,
    :created_at,
    :updated_at

  def attributes
    hsh = super

    hsh[:links] = {}.tap do |h|
      h[:products]         = object.product_ids unless scope == :index
      h[:removed_products] = object.removed_product_ids
      h[:added_products]   = object.added_product_ids
      h[:stores]           = object.store_ids unless scope == :index
      h[:removed_stores]   = object.removed_store_ids
      h[:added_stores]     = object.added_store_ids
    end

    hsh
  end

  def filter(keys)
    if scope == :csv
      keys.delete_if { |k| k.to_s.end_with?('_ids') }
    end

    keys
  end
end
