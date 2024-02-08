It seems that Alan is attempting to reassign the state of `@quantity` within the `update_quantity` method, however there is no setter method established for the instance variable. Secondly, if there were an setter method created, Alan would need to prepend `quantity` with `self.` to not confuse a setter method with a local variable initialization.

The easy, and most appropriate fix in this situation is to simply change `quantity` to `@quantity` so that the instance variable will be reassigned within the `update_quantity` method.

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
end
```