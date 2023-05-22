type updateBinding<T> = (value: T) -> ()

export type info = {
    description: string?,
    name: string,
    order: number,
    theme: theme,
    ref: RoactRef<Frame & { Tips: Frame }>,
    tip: { opened: boolean, update: (value: boolean) -> () }
}

export type theme = {
    schemeColor: Color3,
    background: Color3,
    header: Color3,
    textColor: Color3,
    elementColor: Color3,
} 

return {}
