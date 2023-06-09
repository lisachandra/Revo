local Roact: Roact = require(script.Parent.Parent.Roact) :: any

export type Mainframe = Frame & { Side: Frame & { Tabs: Frame }, Pages: Frame, Tips: Frame }

export type Info = {
    description: string?,
    name: string,
    order: number,
    location: string,
}

export type Theme = {
    schemeColor: Color3,
    background: Color3,
    header: Color3,
    textColor: Color3,
    elementColor: Color3,
}

export type elementProps<T> = {
    info: Info,
    initialValue: T,

    update: (value: T) -> (),
}

return {
    WindowContext = Roact.createContext((nil :: any) :: { theme: Theme, ref: RoactRef<Mainframe> })
}
