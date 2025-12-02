-- Migration: Add lignes_devis_custom column to leads table
-- Purpose: Allow manual entry of custom devis lines after phone call
-- Date: 2025-12-02

-- Add the new column to store custom devis lines as JSONB
ALTER TABLE leads 
ADD COLUMN IF NOT EXISTS lignes_devis_custom JSONB DEFAULT NULL;

-- Add comment for documentation
COMMENT ON COLUMN leads.lignes_devis_custom IS 'Custom devis lines entered manually after phone call. Format: [{"designation": "...", "quantite": X, "unite": "...", "prix_unitaire_ht": X}]';

-- Create index for better query performance (optional but recommended)
CREATE INDEX IF NOT EXISTS idx_leads_lignes_devis_custom 
ON leads USING GIN (lignes_devis_custom);
