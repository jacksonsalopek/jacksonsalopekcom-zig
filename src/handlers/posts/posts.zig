const std = @import("std");
const zap = @import("zap");

pub fn handle(r: zap.SimpleRequest) void {
    var buffer: [128]u8 = undefined;
    var splits = std.mem.split(u8, r.path.?, "/");
    var id: []const u8 = "";
    var idx: u4 = 0;
    while (splits.next()) |split| {
        if (idx == 0 or idx == 1) {
            idx += 1;
            continue;
        } else {
            id = split;
        }
    }
    const body = std.fmt.bufPrintZ(&buffer,
        \\<html>
        \\  <body>
        \\    <h1>Posts</h1>
        \\    <p>{s}</p>
        \\  </body> 
        \\</html>
    , .{id}) catch {
        r.sendError(error.PostsBufferError, 400);
        return;
    };
    r.sendBody(body) catch return;
}
