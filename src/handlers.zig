const HEALTHCHECK_HANDLER = @import("./handlers/healthcheck.zig");
const INDEX_HANDLER = @import("./handlers/index/index.zig");
const APPS_HANDLER = @import("./handlers/apps/apps.zig");
const BLOG_HANDLER = @import("./handlers/blog/blog.zig");
const BLOG_POST_HANDLER = @import("./handlers/blog/post/blog-post.zig");

pub const healthcheck = HEALTHCHECK_HANDLER;
pub const index = INDEX_HANDLER;
pub const apps = APPS_HANDLER;
pub const blog = BLOG_HANDLER;
pub const blog_post = BLOG_POST_HANDLER;
