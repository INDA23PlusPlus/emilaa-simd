const std = @import("std");
const alg = @import("linalg_vec4.zig");

const Random = std.rand.DefaultPrng;

pub fn main() !void {
    var rng = Random.init( @intCast(std.time.timestamp()) );

    var total: f64 = 0;
    for(0..100) |_| {
        for(0..10_000_000) |_| {
            const mat_a = [16]f64{
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64)
            };

            const mat_b = [16]f64{
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64)
            };

            const start = try std.time.Instant.now();
            const r = std.mem.doNotOptimizeAway( alg.mat_mul_mat(mat_a, mat_b) );
            const end = try std.time.Instant.now();
            _ = r;
            total += @floatFromInt(end.since(start));
        }
    }

    total /= 100.0;
    std.debug.print("10.000.000 matrix multiplications: {d:.3} ms avg\n", .{ total / std.time.ns_per_ms });

    total = 0;
    for(0..100) |_| {
            for(0..10_000_000) |_| {
            const mat_a = alg.Mat4{
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64)
            };

            const mat_b = alg.Mat4{
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64),
                rng.random().float(f64), rng.random().float(f64), rng.random().float(f64), rng.random().float(f64)
            };

            const start = try std.time.Instant.now();
            const r = std.mem.doNotOptimizeAway( alg.mat_mul_mat_simd(mat_a, mat_b) );
            const end = try std.time.Instant.now();
            _ = r;
            total += @floatFromInt(end.since(start));
        }
    }

    total /= 100.0;
    std.debug.print("10.000.000 matrix multiplications: {d:.3} ms avg (SIMD)\n", .{ total / std.time.ns_per_ms });
}