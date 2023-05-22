local function merge<A, B>(a: A, b: B): A & B
    assert(type(a) == "table")
    assert(type(b) == "table")

    local new = table.clone(a); for key, value in pairs(b) do
        new[key] = value
    end

    return new :: any
end

return merge
