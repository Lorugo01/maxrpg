-- Adicionar sistema de habilitação/desabilitação para elementos do sistema

-- Adicionar coluna enabled na tabela classes
ALTER TABLE public.classes 
ADD COLUMN IF NOT EXISTS enabled boolean NOT NULL DEFAULT true;

-- Adicionar coluna enabled na tabela races
ALTER TABLE public.races 
ADD COLUMN IF NOT EXISTS enabled boolean NOT NULL DEFAULT true;

-- Adicionar coluna enabled na tabela backgrounds
ALTER TABLE public.backgrounds 
ADD COLUMN IF NOT EXISTS enabled boolean NOT NULL DEFAULT true;

-- Adicionar coluna enabled na tabela equipment
ALTER TABLE public.equipment 
ADD COLUMN IF NOT EXISTS enabled boolean NOT NULL DEFAULT true;

-- Adicionar coluna enabled na tabela spells
ALTER TABLE public.spells 
ADD COLUMN IF NOT EXISTS enabled boolean NOT NULL DEFAULT true;

-- Adicionar coluna enabled na tabela feats
ALTER TABLE public.feats 
ADD COLUMN IF NOT EXISTS enabled boolean NOT NULL DEFAULT true;

-- Comentários explicativos
COMMENT ON COLUMN public.classes.enabled IS 'Define se a classe está habilitada para aparecer na criação de personagens';
COMMENT ON COLUMN public.races.enabled IS 'Define se a raça está habilitada para aparecer na criação de personagens';
COMMENT ON COLUMN public.backgrounds.enabled IS 'Define se o background está habilitado para aparecer na criação de personagens';
COMMENT ON COLUMN public.equipment.enabled IS 'Define se o equipamento está habilitado para aparecer na criação de personagens';
COMMENT ON COLUMN public.spells.enabled IS 'Define se a magia está habilitada para aparecer na criação de personagens';
COMMENT ON COLUMN public.feats.enabled IS 'Define se o feat está habilitado para aparecer na criação de personagens';

-- Criar índices para melhor performance nas consultas filtradas
CREATE INDEX IF NOT EXISTS idx_classes_enabled ON public.classes (enabled);
CREATE INDEX IF NOT EXISTS idx_races_enabled ON public.races (enabled);
CREATE INDEX IF NOT EXISTS idx_backgrounds_enabled ON public.backgrounds (enabled);
CREATE INDEX IF NOT EXISTS idx_equipment_enabled ON public.equipment (enabled);
CREATE INDEX IF NOT EXISTS idx_spells_enabled ON public.spells (enabled);
CREATE INDEX IF NOT EXISTS idx_feats_enabled ON public.feats (enabled);
