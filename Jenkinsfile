terraform([
    aws: [role: "jenkins-devops", account: "435559816706"],
    stages: [
        [name: "Dev", approval: true],
        [name: "QA", approval: true],
        [name: "Pre-Production", approval: true, slug: "preprod", aws: [account: "191125840152"], extra: [workspace: "default"]],
        [name: "Production", approval: true, slug: "prod", aws: [account: "191125840152"]]
    ]
])
