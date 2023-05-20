type updateBinding<T> = (value: T) -> ()

export type info = {
    description: string?,
    order: number,
    theme: theme,
}

export type theme = {
    schemeColor: Color3,
    background: Color3,
    header: Color3,
    textColor: Color3,
    elementColor: Color3,
}

export type toggle = {
    info: info,
    initialValue: boolean,
    binding: updateBinding<boolean>,
}

export type keybind = {
    info: info,
    initialValue: { Enum.KeyCode | Enum.UserInputType },
    binding: updateBinding<boolean>,
}

export type dropdown = {
    info: info,
    initialValue: string,

    values: { string },
    binding: updateBinding<string>,
}

export type textBox = {
    info: info,
    initialValue: string,

    binding: updateBinding<string>,
}

export type colorPicker = {
    info: info,
    initialValue: Color3,

    binding: updateBinding<Color3>,
}

export type button = {
    info: info,

    pressed: () -> (),
}

return {}
