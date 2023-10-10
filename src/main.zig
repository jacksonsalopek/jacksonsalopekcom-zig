const std = @import("std");
const zap = @import("zap");

// Local imports
const err = @import("./error.zig");
const log = @import("./log.zig");
const routes = @import("./routes.zig");

/// Function that is called when a request is received
fn on_request(r: zap.SimpleRequest) void {
    if (routes.matchRoute(r)) |handler| {
        handler(r);
        return;
    } else {
        err.notFoundErr(r);
    }
}

pub fn main() !void {
    // Initialize the allocator for reading environment variables
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    // Read environment variables
    const env_map = try arena.allocator().create(std.process.EnvMap);
    env_map.* = try std.process.getEnvMap(arena.allocator());
    defer env_map.deinit();

    // Read the port from the environment variables if provided, otherwise use 3000
    const port_str: ?[]const u8 = env_map.get("PORT") orelse null;
    const port: u16 = if (port_str) |str| try std.fmt.parseInt(u16, str, 10) else 3000;

    // Initialize the zap HTTP listener
    var listener = zap.SimpleHttpListener.init(.{
        .port = port,
        .on_request = on_request,
        .log = true,
        .public_folder = "public",
    });
    try listener.listen();

    // Write logs indicating that the server is listening
    std.debug.print("\n", .{}); // print a newline after the listener starts
    log.write(.info, .default, "Listening on 0.0.0.0:{any}", .{port});

    // Start the zap server
    zap.start(.{
        .threads = 1,
        .workers = 1,
    });
}
