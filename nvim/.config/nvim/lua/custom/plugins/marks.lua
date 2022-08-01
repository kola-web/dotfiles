local present, marks = pcall(require, "marks")

if not present then
	return
end

marks.setup({
})
