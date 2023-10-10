const std = @import("std");
const zap = @import("zap");
const layout = @import("../../../layout.zig");
const content = @embedFile("./content.html");

pub fn handle(r: zap.SimpleRequest) void {
    var allocator = std.heap.page_allocator;
    const rendered_output = layout.renderInLayout(&allocator, layout.Layout.Base, content) catch |err| {
        std.debug.print("Error rendering content: {any}\n", .{err});
        r.sendError(error.RenderError, 400);
        return;
    };
    r.setContentType(.HTML) catch return;
    r.sendBody(rendered_output) catch return;
    allocator.free(rendered_output);
}
