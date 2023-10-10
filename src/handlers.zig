const HEALTHCHECK_HANDLER = @import("./handlers/healthcheck.zig");
const INDEX_HANDLER = @import("./handlers/index/index.zig");
const APPS_HANDLER = @import("./handlers/apps/apps.zig");
const POSTS_HANDLER = @import("./handlers/posts/posts.zig");

pub const healthcheck = HEALTHCHECK_HANDLER;
pub const index = INDEX_HANDLER;
pub const apps = APPS_HANDLER;
pub const posts = POSTS_HANDLER;
