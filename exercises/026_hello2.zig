//
// Great news! Now we know enough to understand a "real" Hello World
// program in Zig - one that uses the system Standard Out resource...which
// can fail!
//
const std = @import("std");

// Take note that this main() definition now returns "!void" rather
// than just "void". Since there's no specific error type, this means
// that Zig will infer the error type. This is appropriate in the case
// of main(), but can make a function harder (function pointers) or
// even impossible to work with (recursion) in some situations.
//
// You can find more information at:
// https://ziglang.org/documentation/master/#Inferred-Error-Sets
//
pub fn main(init: std.process.Init) !void {
    // Instance for input/output operations; we will learn more about this later.
    const io = init.io;

    // We get a Writer for Standard Out...
    var stdout_writer = std.Io.File.stdout().writer(io, &.{});
    // ...and extract its interface so we can print() to it.
    const stdout = &stdout_writer.interface;

    // Unlike std.debug.print(), the Standard Out writer can fail
    // with an error. We don't care _what_ the error is, we want
    // to be able to pass it up as a return value of main().
    //
    // We just learned of a single statement which can accomplish this.
    try stdout.print("Hello world!\n", .{});
}

// Now you must be thinking "Why would I need to do this instead of good
// old 'std.debug.print()'?", but here's what you need to understand:
// 'std.debug.print()' prints its output to stderr, while the stdout_writer
// approach prints to stdout.
// A common practice is to pipe output of a command to other commands,
// and in order for the piping to work, those commands expect their input
// to come from stdout, not stderr.
