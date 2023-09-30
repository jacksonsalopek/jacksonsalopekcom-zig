const std = @import("std");
const zap = @import("zap");
const log = @import("./log.zig");
const handlers = @import("./handlers/index.zig");

/// Struct representing a route and its handler.
const Route = struct {
    method: []const u8,
    path: []const u8,
    handler: *const fn (r: zap.SimpleRequest) void,
};

// Define routes here
const ROUTES = [_]Route{Route{ .method = "GET", .path = "/healthcheck", .handler = handlers.healthcheck.handle }};

/// Returns a handler function for the given route, or null if no route matches.
pub fn matchRoute(r: zap.SimpleRequest) ?*const fn (zap.SimpleRequest) void {
    var buffer: [256]u8 = undefined; // Adjust the size as needed

    for (ROUTES) |route| {
        const endPos: []u8 = std.fmt.bufPrint(&buffer, "{s}/", .{route.path}) catch {
            log.write(.err, .router, "Error: Not enough space in buffer\n", .{});
            return null;
        };

        const concatenatedPath = endPos;

        if (std.mem.eql(u8, r.method.?, route.method) and
            (std.mem.eql(u8, r.path.?, route.path) or std.mem.eql(u8, r.path.?, concatenatedPath)))
        {
            return route.handler;
        }
    }

    return null;
}
