

high_order_function = lambda x, fun : x + fun(x)

print(high_order_function(20, lambda x: x*x))
