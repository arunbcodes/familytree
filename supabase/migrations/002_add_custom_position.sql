-- Add custom position columns for manual node positioning
-- These store user-defined positions when dragging nodes on the canvas

ALTER TABLE public.persons 
ADD COLUMN IF NOT EXISTS custom_x DOUBLE PRECISION,
ADD COLUMN IF NOT EXISTS custom_y DOUBLE PRECISION;

-- Add comment for documentation
COMMENT ON COLUMN public.persons.custom_x IS 'Custom X position set by user dragging the node';
COMMENT ON COLUMN public.persons.custom_y IS 'Custom Y position set by user dragging the node';

