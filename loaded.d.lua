export type Packager = (user: string, repo: string, branch: string, src: string, aliases: { string }?) -> (() -> any)
export type RoactTemplate = {
    fromInstance: (RoactPath: ModuleScript, instance: Instance) -> RoactElement,
    wrapped: (component: any, props: table, templateKey: any?) -> any,
}
