terraform([
    aws: [role: "jenkins-devops", account: "435559816706"],
    stages: [
        [name: "Dev"],
        [name: "QA"],
        [name: "Pre-Production", slug: "preprod", aws: [account: "191125840152"], extra: [workspace: "default"]],
        [name: "Production", slug: "prod", aws: [account: "191125840152"]]
    ]
])
