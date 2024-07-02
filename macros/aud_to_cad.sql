{% macro aud_to_cad(aud_amount, exchange_rate) %}
    ({{ aud_amount }} * {{ exchange_rate }})
{% endmacro %}
