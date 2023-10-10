const std = @import("std");
const zap = @import("zap");
const html = @embedFile("./click-response.html");

pub fn handle(r: zap.SimpleRequest) void {
    r.sendBody(html) catch return;
}
