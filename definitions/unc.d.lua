-- As of commit https://github.com/unified-naming-convention/NamingStandard/commit/f6d77d99f008c7e6310e33ecfdbe696e40b34a69

declare game: DataModel & {
    HttpGet: (self: DataModel, url: string) -> string
}

-- Scripts
-- The script functions provide access to script environments and internal state.

declare function getgc(includeTables: boolean?): { any }
declare function getgenv(): { [string]: any }
declare function getloadedmodules(excludeCore: boolean?): { ModuleScript }
declare function getrenv(): { [string]: any }
declare function getrunningscripts(): { LocalScript | ModuleScript }
declare function getscriptbytecode(script: LocalScript | ModuleScript): string
declare function getscriptclosure(script: LocalScript | ModuleScript): () -> ()
declare function getscripthash(script: LocalScript | ModuleScript): string
declare function getscripts(): { LocalScript | ModuleScript }
declare function getsenv(script: LocalScript | ModuleScript): { [string]: any }
declare function getthreadidentity(): number
declare function setthreadidentity(identity: number): ()

-- Miscellaneous
-- The miscellaneous functions are a temporary collection of functions that are not yet categorized.

type HttpRequest = {
    Url: string,
    Method: "GET" | "POST" | "PATCH" | "PUT",
    Body: string?,
    Headers: { [string]: string }?,
    Cookies: { [string]: string }?,
}

type HttpResponse = {
    Body: string,
    StatusCode: number,
    StatusMessage: number,
    Success: boolean,
    Headers: { [string]: string },
}

declare function identifyexecutor(): (string, string)
declare function lz4compress(data: string): string
declare function lz4decompress(data: string, size: number): string
declare function messagebox(text: string, caption: string, flags: number): number
declare function queue_on_teleport(code: string): ()
declare function request(options: HttpRequest): HttpResponse
declare function setclipboard(text: string): ()
declare function setfpscap(fps: number): ()

-- Metatable
-- The metatable functions allow elevated access to locked metatables.

declare function getrawmetatable(object: table): table
declare function hookmetamethod(object: table, method: string, hook: () -> ()): () -> ()
declare function getnamecallmethod(): string
declare function isreadonly(object: table): boolean
declare function setrawmetatable(object: table, metatable: table): ()
declare function setreadonly(object: table, readonly: boolean): ()

-- Instances
-- The Instance functions are used to interact with game objects and their properties.

type Connection = {
    Enabled: boolean,
    ForeignState: boolean,
    LuaConnection: boolean,
    Function: (() -> ())?,
    Thread: thread?,

    Fire: (self: Connection, ...any) -> (),
    Defer: (self: Connection, ...any) -> (),
    Disconnect: (self: Connection) -> (),
    Disable: (self: Connection) -> (),
    Enable: (self: Connection) -> (),
}

declare function fireclickdetector(object: ClickDetector, distance: number?, event: string?): ()
declare function getcallbackvalue(object: Instance, property: string): (() -> ())?
declare function getconnections(signal: RBXScriptSignal): { Connection }
declare function getcustomasset(path: string, noCache: boolean): string
declare function gethiddenproperty(object: Instance, property: string): (any, boolean)
declare function gethui(): Folder
declare function getinstances(): { Instance }
declare function getnilinstances(): { Instance }
declare function isscriptable(object: Instance, property: string): boolean
declare function sethiddenproperty(object: Instance, property: string, value: any): boolean
declare function setrbxclipboard(data: string): boolean
declare function setscriptable(object: Instance, property: string, value: boolean): boolean

-- Input
-- The input functions allow you to dispatch inputs on behalf of the user.

type uint = number

declare function isrbxactive(): boolean
declare function iswindowactive(): boolean
declare function mousescroll(px: number): ()
declare function mouse1click(): ()
declare function mouse1press(): ()
declare function mouse1release(): ()
declare function mouse2click(): ()
declare function mouse2press(): ()
declare function mouse2release(): ()
declare function keypress(keycode: uint): ()
declare function keyrelease(keycode: uint): ()
declare function mousemoveabs(x: number, y: number): ()
declare function mousemoverel(x: number, y: number): ()

-- Filesystem
-- The filesystem functions allow read and write access to a designated folder in the directory of the executor, typically called workspace.

declare function readfile(path: string): string
declare function listfiles(path: string): {string}
declare function writefile(path: string, data: string): ()
declare function makefolder(path: string): ()
declare function appendfile(path: string, data: string): ()
declare function isfile(path: string): boolean
declare function isfolder(path: string): boolean
declare function delfile(path: string): ()
declare function delfolder(path: string): ()
declare function loadfile(path: string, chunkname: string?): (() -> ...any?, string?)
declare function dofile(path: string): ()

-- Debug
-- The debug library is an extension of the Luau debug library, providing greater control over Luau functions.
-- As of commit https://github.com/JohnnyMorganz/luau-lsp/commit/9ba9c56100cee3710e0e248c2cb5cb217ab7f331

type DebugInfo = {
    source: string,
    short_src: string,
    func: () -> (),
    what: "Lua" | "C",
    currentline: number,
    name: string,
    nups: number,
    numparams: number,
    is_vararg: number,
}

declare debug: {
    info: (<R...>(thread, number, string) -> R...) & (<R...>(number, string) -> R...) & (<A..., R1..., R2...>((A...) -> R1..., string) -> R2...),
    traceback: ((string?, number?) -> string) & ((thread, string?, number?) -> string),
    profilebegin: (label: string) -> (),
    profileend: () -> (),
    setmemorycategory: (tag: string) -> (),
    resetmemorycategory: () -> (),

    getconstant: (func: () -> () | number, index: number) -> any,
    getconstants: (func: () -> () | number) -> { any },
    getinfo: (func: () -> () | number) -> DebugInfo,
    getproto: (func: () -> () | number, index: number, active: boolean?) -> (() -> ()) | { () -> () },
    getprotos: (func: () -> () | number) -> { () -> () },
    getstack: (level: number, index: number?) -> any | { any },
    getupvalue: (func: () -> () | number, index: number) -> any,
    getupvalues: (func: () -> () | number) -> { any },
    setconstant: (func: () -> () | number, index: number, value: any) -> (),
    setstack: (level: number, index: number, value: any) -> (),
    setupvalue: (func: () -> () | number, index: number, value: any) -> (),
}

-- Crypt
-- The crypt library provides methods for the encryption and decryption of string data.
-- Behavior and examples documented on this page are based on Script-Ware.

declare crypt: {
    base64encode: (data: string) -> string,
    base64decode: (data: string) -> string,
    encrypt: (data: string, key: string, iv: string?, mode: string?) -> (string, string),
    decrypt: (data: string, key: string, iv: string, mode: string) -> string,
    generatebytes: (size: number) -> string,
    generatekey: () -> string,
    hash: (data: string, algorithm: string) -> string,
}

-- Console
-- The console functions are used to interact with one console window.
-- Behavior and examples documented on this page are based on Script-Ware.

declare function rconsoleclear(): ()
declare function rconsolecreate(): ()
declare function rconsoledestroy(): ()
declare function rconsoleinput(): string
declare function rconsoleprint(text: string): ()
declare function rconsolesettitle(title: string): ()

-- Closures
-- The closure functions are used to create, identify, and interact with Luau closures.

declare function checkcaller(): boolean
declare function clonefunction<T>(func: T): T
declare function getcallingscript(): BaseScript
declare function hookfunction<T>(func: T, hook: () -> ()): T
declare function iscclosure(func: () -> ()): boolean
declare function islclosure(func: () -> ()): boolean
declare function isexecutorclosure(func: () -> ()): boolean
declare function loadstring(source: string, chunkname: string?): (() -> ...any, string?)
declare function newcclosure<T>(func: T): T

-- Cache
-- The cache library provides methods for modifying the internal Instance cache.

declare cache: {
    invalidate: (object: Instance) -> (),
    iscached: (object: Instance) -> boolean,
    replace: (object: Instance, newObject: Instance) -> (),
}

declare function cloneref<T>(object: T): T
declare function compareinstances(a: Instance, b: Instance): boolean

-- WebSocket
-- The WebSocket class provides a simple interface for sending and receiving data over a WebSocket connection.

type WebSocketEvent<T... = ...any> = {
    Wait: (self: WebSocketEvent<T...>) -> T...,
    Connect: (self: WebSocketEvent<T...>, callback: (T...) -> ()) -> (),
}

declare class WebSocket
    OnMessage: WebSocketEvent<string>
    OnClose: WebSocketEvent<>

    function Send(self, message: string): ()
    function Close(self): ()
end

declare WebSocket: {
    connect: ((url: string) -> WebSocket),
}

-- Drawing
-- The Drawing class provides an interface for drawing shapes and text above the game window.

type Fonts = {
    UI: number,
    System: number,
    Plex: number,
    Monospace: number,
}

declare function cleardrawcache(): ()
declare function getrenderproperty(drawing: Drawing, property: string): any
declare function isrenderobj(object: any): boolean
declare function setrenderproperty(drawing: Drawing, property: string, value: any): ()

declare class Drawing
    Visible: boolean
    ZIndex: number
    Transparency: number
    Color: Color3

    function Destroy(self): ()
end

declare class Line extends Drawing
    From: Vector2
    To: Vector2
    Thickness: number
end

declare class Text extends Drawing
    Text: string
    TextBounds: Vector2
    Font: Fonts
    Size: number
    Position: Vector2
    Center: boolean
    Outline: boolean
    OutlineColor: Color3
end

declare class Image extends Drawing
    Data: string
    Size: Vector2
    Position: Vector2
    Rounding: number
end

declare class Circle extends Drawing
    NumSides: number
    Radius: number
    Position: Vector2
    Thickness: number
    Filled: boolean
end

declare class Square extends Drawing
    Size: Vector2
    Position: Vector2
    Thickness: number
    Filled: boolean
end

declare class Quad extends Drawing
    PointA: Vector2
    PointB: Vector2
    PointC: Vector2
    PointD: Vector2
    Thickness: number
    Filled: boolean
end

declare class Triangle extends Drawing
    PointA: Vector2
    PointB: Vector2
    PointC: Vector2
    Thickness: number
    Filled: boolean
end

declare Drawing: {
    Fonts: Fonts,
    new: (((type: "Line") -> Line) & ((type: "Text") -> Text) & ((type: "Image") -> Image) & ((type: "Circle") -> Circle) & ((type: "Square") -> Square) & ((type: "Quad") -> Quad) & ((type: "Triangle") -> Triangle))
}