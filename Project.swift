import ProjectDescription

let projectName = "Memo"
let organizatiionName = "baegteun"

let project = Project(
    name: projectName,
    organizationName: organizatiionName,
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "\(organizatiionName).\(projectName)",
            deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
            infoPlist: .file(path: Path("Support/Info.plist")),
            sources: ["Source/**"],
            resources: ["Resource/**"]
        )
    ]
)
