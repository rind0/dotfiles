local feline_ok, feline = pcall(require, 'feline')
if not feline_ok then
	return
end
feline.setup()
