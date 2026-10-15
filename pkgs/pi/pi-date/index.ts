/**
 * Date-Injector Extension
 *
 * Injects current date into system prompt using systemPromptOptions.sections.
 * This ensures the agent always has access to the current date, preventing
 * date-awareness errors in time-sensitive tasks.
 *
 * Usage: Load via --extension flag or add to extensions directory.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", async (event) => {
    const currentDate = new Date().toLocaleString(undefined, {
      weekday: 'long',
      year: 'numeric',
      month: 'numeric',
      day: 'numeric',
      hour: 'numeric',
      minute: 'numeric',
      timeZoneName: 'short',
      hour12: false,
    });

    // Use sections.addendum (preferred per extensions.md)
    // Pi appends this as a delta instead of replacing entire prompt
    event.systemPromptOptions.sections.addendum =
      `The date is ${currentDate}.`;
  });
}
