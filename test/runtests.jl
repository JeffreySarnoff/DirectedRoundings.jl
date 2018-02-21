using DirectedRoundings
using Test


# arithmetic function examples
#   the directed rounding functions work with 1,2,3,4 params

function sqrt5x(a)
    sqrt(5*a)
end

function reldiff(a, b)
    return (a - b) / a
end

function affine_map(x, shift, scale)
    return (x + shift) * scale
end

function right_triangles_ratio(a_adjacent, a_opposite, 
                               b_adjacent, b_opposite)
    a_hypot = hypot(a_adjacent, a_opposite)
    b_hypot = hypot(b_adjacent, b_opposite)
    return a_hypot / b_hypot
end


const FP = Float32

a = FP(3); b = FP(4096); c = inv(FP(17)); d = eps(a)/2;

round_nearest(inv,a)
round_up(inv, a)
round_down(inv, a)
round_tozero(inv, a)
round_fromzero(inv, a)

round_up(+, a, b)
round_down(hypot, a, b)

round_up(affine_map, a, b, c)
round_down(affine_map, a, b, c)

round_nearest(right_triangles_ratio, a, b, c, d)
round_up(right_triangles_ratio, a, b, c, d)
round_down(right_triangles_ratio, a, b, c, d)
