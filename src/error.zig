const zap = @import("zap");

/// Sends a 404 error response.
pub fn notFoundErr(r: zap.SimpleRequest) void {
    r.sendError(error.NotFound, 404);
}
