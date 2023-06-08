type updateBinding<T> = (value: T) -> ()

export type info = {
    description: string?,
    name: string,
    order: number,
    theme: theme,
    ref: RoactRef<Frame & { Tips: Frame }>,
    location: string,
}

export type theme = {
    schemeColor: Color3,
    background: Color3,
    header: Color3,
    textColor: Color3,
    elementColor: Color3,
}

export type Mainframe = Frame & { Side: Frame & { Tabs: Frame }, Pages: Frame, Tips: Frame }

return {}
