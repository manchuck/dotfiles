local cg = require("chatgpt")
cg.setup({
	predefined_chat_gpt_prompts = {
		{
			title = "Docstring (TS)",
			prompt = "Write a concise JSDoc for the selected TypeScript function.",
		},
		{
			title = "Explain",
			prompt = "Explain the selected code to a sr engineer.",
		},
	},
})
