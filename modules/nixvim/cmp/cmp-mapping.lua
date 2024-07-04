cmp.mapping.preset.insert ({
	['<C-Space>'] = cmp.mapping.complete();
	['<C-j>'] = cmp.mapping.scroll_docs(4);
	['<C-k>'] = cmp.mapping.scroll_docs(-4);
	['<C-l>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true });
	['<C-n>'] = cmp.mapping(function(fallback)
	  if cmp.visible() then
			cmp.select_next_item()
		elseif require("luasnip").expand_or_jumpable() then
			require("luasnip").expand_or_jump()
		else
			fallback()
		end
	end, {'i', 's'});
	['<C-p>'] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif require("luasnip").expand_or_jumpable() then
			require("luasnip").expand_or_jump()
		else
			fallback()
		end
	end, {'i', 's'});
})
