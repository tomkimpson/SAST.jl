
"""
A function that does x y and z
"""
function get_milankovic_elements(a,e,ι,Ω,ω,M)


    η = sqrt(1-e^2)
    sin_ι,cos_ι = sincos(ι)
    sin_Ω, cos_Ω = sincos(Ω)
    sin_ω, cos_ω = sincos(ω)
    scale = sqrt(mu*a)

    x = zeros(typeof(a),7)
    x[1]= scale * η * (sin_ι * sin_Ω)
    x[2]= scale * η * (-sin_ι * cos_Ω)
    x[3]= scale * η * cos_ι
    x[4]= e * (cos_ω * cos_Ω - cos_ι * sin_ω * sin_Ω)
    x[5]= e * (cos_ω * sin_Ω + cos_ι * sin_ω * cos_Ω)
    x[6]= e * (sin_ι * sin_ω)
    x[7]= Ω+ω+M

    return x 

end 




function sun(t_julian_centuries)

 
    #where do these coeffecients come from? ideally should be declared in struct or globall
    #do we need a mod function here? 
    mean_longitude_degrees = 280.4606184 + 36000.77005361*t_julian_centuries
    mean_anomaly_radians = 357.5277233 + 35999.05034*t_julian_centuries


    ecliptic_longitude_degrees = mean_longitude_degrees + 1.914666471*sin(mean_anomaly_radians)+0.019994643*sin(2.0*mean_anomaly_radians)
    obliquity_degrees = 23.439291 - 0.0130042*t_julian_centuries  

    #mean_longitude_radians = deg2rad(mean_longitude_degrees) 

    # IF ( MeanLong .lt. 0.0D0 ) THEN
    #     MeanLong= TwoPi + MeanLong
    # ENDIF

    ecliptic_longitude_radians = deg2rad(ecliptic_longitude_degrees) 
    obliquity_radians= deg2rad(obliquity_degrees) 


    m = (1.000140612 - 0.016708617*cos(mean_anomaly_radians)- 0.000139589*cos( 2.0*mean_anomaly_radians ))*AU   #this is a magnitude in AU
    sun_vector = zeros(typeof(t_julian_centuries),3)

    sun_vector[1]= m*cos(ecliptic_longitude_radians )
    sun_vector[2]= m*cos(obliquity_radians)*sin(ecliptic_longitude_radians)
    sun_vector[3]= m*sin(obliquity_radians)*sin(ecliptic_longitude_radians)

    right_ascension = atan(cos(obliquity_radians)*tan(ecliptic_longitude_radians),ecliptic_longitude_radians ) #in julia atan = atan2 - do e need the previous correction?

    declination  = asin( sin(obliquity_radians)*sin(ecliptic_longitude_radians))

    return sun_vector,right_ascension,declination


# ! --- Check that RtAsc is in the same quadrant as EclpLong ----
# IF ( EclpLong .lt. 0.0D0 ) THEN
#     EclpLong= EclpLong + TwoPi    ! make sure it's in 0 to 2pi range
#   ENDIF
# IF ( ABS( EclpLong-RtAsc ) .gt. Pi*0.5D0 ) THEN
#     RtAsc= RtAsc + 0.5D0*Pi*NINT( (EclpLong-RtAsc)/(0.5D0*Pi))
#   ENDIF


end 