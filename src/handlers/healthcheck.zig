const std = @import("std");
const zap = @import("zap");
const log = @import("../log.zig");

const HealthStatus = enum {
    Healthy,
    Unhealthy,
};

const HealthcheckResponse = struct {
    status: HealthStatus,
    time: i64,
};

pub fn handle(r: zap.SimpleRequest) void {
    const res = HealthcheckResponse{
        .status = .Healthy,
        .time = std.time.milliTimestamp(),
    };
    var buf: [80]u8 = undefined;
    var json: []const u8 = undefined;
    if (zap.stringifyBuf(&buf, res, .{})) |obj| {
        json = obj;
    } else {
        log.write(.info, .default, "Failed to stringify HealthcheckResponse\n", .{});
        json = "null";
    }
    log.write(.info, .default, "HealthcheckResponse: {s}\n", .{json});
    r.setContentType(.JSON) catch return;
    r.sendJson(json) catch return;
}
