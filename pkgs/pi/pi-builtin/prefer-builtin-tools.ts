/**
 * Prefer Builtin Tools Extension
 *
 * Instructs PI to prefer read/edit tools over shell commands for file operations.
 * Blocks sed commands and directs users to use builtin tools instead.
 */
import type { ExtensionAPI, UserBashEvent } from "@earendil-works/pi-coding-agent";

export default function preferBuiltinTools(pi: ExtensionAPI) {
  // Strengthen system prompt guidelines
  pi.on("before_agent_start", async (event) => {
    event.systemPromptOptions.promptGuidelines = [
      ...event.systemPromptOptions.promptGuidelines,
      "When working with files, prefer the builtin tools (read, edit, write) over shell commands.",
      "NEVER use sed, awk, perl, or similar shell tools for file reads or edits.",
      "The edit tool provides safer, more reliable file modifications with proper error handling.",
    ];
  });

  // Block sed commands from agent bash tool calls
  pi.on("tool_call", async (event, ctx) => {
    if (event.toolName === "bash") {
      const input = event.input as { command?: string };
      const command = input.command?.trim() || "";

      if (/^sed(\s|$)/.test(command)) {
        return {
          block: true,
          reason: "sed is disabled. Use edit or read instead",
        };
      }
    }

    return undefined;
  });
}
