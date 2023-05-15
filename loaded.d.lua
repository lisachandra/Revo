export type Packager = (user: string, repo: string, branch: string, src: string) -> (() -> any)
