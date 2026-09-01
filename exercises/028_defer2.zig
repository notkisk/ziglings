//
// Now that you know how "defer" works, let's do something more
// interesting with it.
//
const std = @import("std");

pub fn main() void {
    const animals = [_]u8{ 'g', 'c', 'd', 'd', 'g', 'z' };

    for (animals) |a| printAnimal(a);

    std.debug.print("done.\n", .{});

    std.debug.print("Answer to everything? {d}\n", .{calculateTheUltimateQuestionOfLife()});
}

// This function is _supposed_ to print an animal name in parentheses
// like "(Goat) ", but we somehow need to print the end parenthesis
// even though this function can return in four different places!
fn printAnimal(animal: u8) void {
    std.debug.print("(", .{});

    defer std.debug.print(") ", .{}); // <---- how?!

    if (animal == 'g') {
        std.debug.print("Goat", .{});
        return;
    }
    if (animal == 'c') {
        std.debug.print("Cat", .{});
        return;
    }
    if (animal == 'd') {
        std.debug.print("Dog", .{});
        return;
    }

    std.debug.print("Unknown", .{});
}

// This function is supposed to calculate the answer to the
// ultimate question of life, the universe, and everything,
// but it needs to be deferred as far in the future as possible,
// in order to gather more data.
//
// When there are multiple defers in a single block, they are executed in reverse order.
// This example might seem silly, but it's important to know when e.g.
// deinitializing containers whose elements need to be deinitialized first.
fn calculateTheUltimateQuestionOfLife() u32 {
    var x: u32 = 100;

    // Try reordering the statements to get the answer 42
    {
        defer x = x * 2;
        defer x = x + 11;
        defer x = x / 10;
    }

    return x;
}
