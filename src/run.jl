



"""
solution,model = orbit(NF,kwargs...)

Runs RelativisticDynamics.jl with number format `NF` and any additional parameters in the keyword arguments
`kwargs...`. Any unspecified parameters will use the default values as defined in `src/parameters.jl`."""
function orbit(::Type{NF}=Float64;              # number format, use Float64 as default
           kwargs...                        # all additional non-default parameters
           ) where {NF<:AbstractFloat}



        x = get_milankovic_elements(1.0,0.2,3.0,4.0,5.0,6.0)


        sun_vector,right_ascension,declination = sun(1.0)

end