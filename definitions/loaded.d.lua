export type Packager = (user: string, repo: string, branch: string, src: string, aliases: { string }?) -> (() -> any)
export type RoactTemplate = {
    fromInstance: (RoactPath: ModuleScript, instance: Instance) -> RoactElement,
    wrapped: <P>(component: RoactElementFn<P>, props: P, templateKey: any?) -> any,
}
