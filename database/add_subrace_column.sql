-- Adicionar colunas faltantes à tabela characters

-- Coluna subrace para subraças (ex: Abissal, Ctônico, Infernal para Tiefling)
ALTER TABLE public.characters 
ADD COLUMN IF NOT EXISTS subrace character varying(50) NULL;

-- Coluna custom_abilities para habilidades personalizadas
ALTER TABLE public.characters 
ADD COLUMN IF NOT EXISTS custom_abilities jsonb NULL DEFAULT '[]'::jsonb;

-- Comentários explicativos
COMMENT ON COLUMN public.characters.subrace IS 'Subraça selecionada pelo personagem (ex: Abissal, Ctônico, Infernal para Tiefling)';
COMMENT ON COLUMN public.characters.custom_abilities IS 'Habilidades personalizadas do personagem em formato JSON';
