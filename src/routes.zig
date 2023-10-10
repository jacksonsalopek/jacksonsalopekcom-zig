const std = @import("std");
const zap = @import("zap");
const log = @import("./log.zig");
const handlers = @import("./handlers.zig");

/// Returns a handler function for the given route, or null if no route matches.
pub fn matchRoute(r: zap.SimpleRequest) ?*const fn (zap.SimpleRequest) void {
    if (std.mem.eql(u8, r.method.?, "GET") and
        (std.mem.eql(u8, r.path.?, "/")))
    {
        return handlers.index.handle;
    }
    if (std.mem.eql(u8, r.method.?, "GET") and
        (std.mem.eql(u8, r.path.?, "/apps")))
    {
        return handlers.apps.handle;
    }
    if (std.mem.eql(u8, r.method.?, "GET") and
        (std.mem.eql(u8, r.path.?, "/healthcheck")))
    {
        return handlers.healthcheck.handle;
    }

    if (std.mem.eql(u8, r.method.?, "GET") and
        (std.mem.startsWith(u8, r.path.?, "/posts/")))
    {
        return handlers.posts.handle;
    }

    return null;
}
