{% docs orders_status %}

Orders can be one of the following statuses:

| status         | description                                                                                                            |
|----------------|------------------------------------------------------------------------------------------------------------------------|
| placed         | The order has been placed but has not yet left the warehouse. This is the initial status of an order.                  |
| shipped        | The order has been shipped to the customer and is currently in transit. The customer can track the shipment.           |
| completed      | The order has been received by the customer. This status indicates successful delivery.                                |
| return_pending | The customer has indicated that they would like to return the order, but it has not yet been received at the warehouse.|
| returned       | The order has been returned by the customer and received at the warehouse. The return process is complete.             |

{% enddocs %}
