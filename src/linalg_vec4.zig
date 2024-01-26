pub const Vec4 = @Vector(4, f64);
pub const Mat4 = @Vector(16, f64);

pub fn mat_mul_vec_simd(vec: Vec4, mat: Mat4) Vec4 {
    return @as(Vec4, @splat(vec[0])) * Vec4{mat[0],mat[4],mat[8 ],mat[12]} +
           @as(Vec4, @splat(vec[1])) * Vec4{mat[1],mat[5],mat[9 ],mat[13]} +
           @as(Vec4, @splat(vec[2])) * Vec4{mat[2],mat[6],mat[10],mat[14]} +
           @as(Vec4, @splat(vec[3])) * Vec4{mat[3],mat[7],mat[11],mat[15]};
}

pub fn mat_mul_mat_simd(mat_a: Mat4, mat_b: Mat4) Mat4 {
    const a = mat_mul_vec_simd(Vec4{mat_b[0], mat_b[4], mat_b[8 ], mat_b[12]}, mat_a);
    const b = mat_mul_vec_simd(Vec4{mat_b[1], mat_b[5], mat_b[9 ], mat_b[13]}, mat_a);
    const c = mat_mul_vec_simd(Vec4{mat_b[2], mat_b[6], mat_b[10], mat_b[14]}, mat_a);
    const d = mat_mul_vec_simd(Vec4{mat_b[3], mat_b[7], mat_b[11], mat_b[15]}, mat_a);

    return .{ a[0], b[0], c[0], d[0],
              a[1], b[1], c[1], d[1],
              a[2], b[2], c[2], d[2],
              a[3], b[3], c[3], d[3] };
}

pub fn mat_mul_vec(vec: [4]f64, mat: [16]f64) [4]f64 {
    return .{ vec[0] * mat[0] + vec[0] * mat[4] + vec[0] * mat[8 ] + vec[0] * mat[12],
              vec[1] * mat[1] + vec[1] * mat[5] + vec[1] * mat[9 ] + vec[1] * mat[13],
              vec[2] * mat[2] + vec[2] * mat[6] + vec[2] * mat[10] + vec[2] * mat[14],
              vec[3] * mat[3] + vec[3] * mat[7] + vec[3] * mat[11] + vec[3] * mat[15]};
}

pub fn mat_mul_mat(mat_a: [16]f64, mat_b: [16]f64) [16]f64 {
    const a = mat_mul_vec([4]f64{mat_b[0], mat_b[4], mat_b[8 ], mat_b[12]}, mat_a);
    const b = mat_mul_vec([4]f64{mat_b[1], mat_b[5], mat_b[9 ], mat_b[13]}, mat_a);
    const c = mat_mul_vec([4]f64{mat_b[2], mat_b[6], mat_b[10], mat_b[14]}, mat_a);
    const d = mat_mul_vec([4]f64{mat_b[3], mat_b[7], mat_b[11], mat_b[15]}, mat_a);

    return .{ a[0], b[0], c[0], d[0],
              a[1], b[1], c[1], d[1],
              a[2], b[2], c[2], d[2],
              a[3], b[3], c[3], d[3] };
}