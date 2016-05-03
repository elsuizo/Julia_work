
tic()
const n = 10000
#=
comentario multiline
coomo est
comentario multiline
coomo estee
=#
y = Array(Float64,n)

z = Array(Float64,n)
k = Array(Int64,n)
y_search = Array(Float64,n)
ϵ = eps(Float64)
Δϵ = (n -1) * ϵ
Δε = 1
s = rand(n)
sort!(s)

v_min = s[1]
v_max = s[end]

m = (v_max - v_min + 2 * Δϵ) / (n - 1)
q = v_min - m - delta_epsilon

z = m .* [1:n] .+ q

#k[1] = 0
#k[end] = n

# old implementation is slow 
#---------------------------------------------------------------------------
#for i in 2:n-1
 #   vec_aux = s .< z[i]
  #  k[i] = sum(vec_aux)
#end
#--------------------------------------------------------------------------

function k_vector(s, z)
    n = length(s)
    k = Array(Int64,n-2)

    for i = 2:n-1
        count = 0

        for j = 1:n
            count += s[j] < z[i]
        end
        k[i-1] = count
    end
    push!(k,n)
    unshift!(k,0)
    return k

end

    
k = k_vector(s,z)            
y_a = .3
y_b = .7

j_b = floor((y_a - q) / m)
j_t = ceil((y_b - q) / m)
# luego de 
k_start = k[j_b] + 1
k_end = k[j_t]

k_search = k_start:k_end

y_search = s[k_search]

if y_search[1] < y_a
    deleteat!(y_search, 1)
end

if y_search[end] > y_b
    deleteat!(y_search, length(y_search))
end
toc()

