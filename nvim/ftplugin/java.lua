local ok, jdtls = pcall(require, "jdtls")
if not ok then
	return
end

local root_dir = require("jdtls.setup").find_root({
	".project",
	".classpath",
	"gradlew",
	"mvnw",
	"pom.xml",
	"build.gradle",
	"settings.gradle",
	".git",
})
if not root_dir then
	return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

local java21 = "/usr/lib/jvm/java-21-openjdk/bin/java"

jdtls.start_or_attach({
	cmd = { "jdtls", "--java-executable", java21, "-data", workspace_dir },
	root_dir = root_dir,
})
