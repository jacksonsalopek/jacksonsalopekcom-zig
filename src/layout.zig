const std = @import("std");
const layout_base = @embedFile("./layouts/base.html");
const layout_blog = @embedFile("./layouts/blog.html");
const layout_blog_post = @embedFile("./layouts/blog-post.html");

pub const Layout = enum { Base, Blog, BlogPost };

pub fn renderInLayout(allocator: *std.mem.Allocator, layout: Layout, content: []const u8) ![]u8 {
    // Open the layout file.
    var contents = std.ArrayList(u8).init(allocator.*);
    const layout_contents = switch (layout) {
        .Base => layout_base,
        .Blog => layout_blog,
        .BlogPost => layout_blog_post,
    };

    var iter = std.mem.split(u8, layout_contents, "\n");
    while (iter.next()) |line| {
        if (std.mem.containsAtLeast(u8, line, 1, "{{content}}")) {
            try contents.appendSlice(content);
        } else {
            try contents.appendSlice(line);
        }
        try contents.append('\n'); // Append newline
    }

    return contents.toOwnedSlice();
}
