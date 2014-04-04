# test on K-Vector Search technique 
# on random database 

#Preprocessing
#*************************************************************************
tic()
n = 10000   # length of database
y = zeros(n)
s = zeros(n)
k = zeros(n)
vec_aux = zeros(n)
y_search = zeros(n)
epsilon = eps(Float64)  # Precision
delta_epsilon = (n - 1) * epsilon

# generating a random database 
y = rand(n)
s = sort(y)
v_min = s[1]
v_max = s[end]
m = (v_max - v_min + 2 * delta_epsilon) / (n - 1)
q = v_min - m - delta_epsilon

# anonymous function 
z = map(x -> m * x + q, [1:n])

# Limits of K-vector
k[1] = 0
k[end] = n

# K-vector construction 
for ind in [2:n-1]
    vec_aux = s .< z[ind]
    k[ind] = sum(vec_aux)
end 

# Range of Search 
y_a = .3 
y_b = .7

j_b = floor((y_a - q ) / m)
j_t = ceil((y_b - q ) / m)

k_start = k[j_b] + 1
k_end = k[j_t]

k_search = [k_start:k_end]

y_search = s[k_search]

# if the number of elements on the database is >> 10 the mean of elements out
# of Range e0 = 1, then is on extremal points

if y_search[1] < y_a 
   deleteat!(y_search, 1)
end 

if y_search[end] > y_b 
deleteat!(y_search, length(y_search))
end
toc() 
