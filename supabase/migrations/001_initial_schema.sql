-- Family Tree App - Initial Schema
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- USERS TABLE (extends Supabase auth.users)
-- ============================================
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view their own profile" 
    ON public.profiles FOR SELECT 
    USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" 
    ON public.profiles FOR UPDATE 
    USING (auth.uid() = id);

CREATE POLICY "Users can insert their own profile" 
    ON public.profiles FOR INSERT 
    WITH CHECK (auth.uid() = id);

-- ============================================
-- FAMILY TREES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.family_trees (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    description TEXT,
    owner_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    visibility TEXT NOT NULL DEFAULT 'private' CHECK (visibility IN ('private', 'family', 'public')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.family_trees ENABLE ROW LEVEL SECURITY;

-- ============================================
-- TREE MEMBERS TABLE (Many-to-Many: Users <-> Trees)
-- ============================================
CREATE TABLE IF NOT EXISTS public.tree_members (
    tree_id UUID NOT NULL REFERENCES public.family_trees(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    person_id UUID, -- Link to their person record in the tree
    role TEXT NOT NULL DEFAULT 'viewer' CHECK (role IN ('owner', 'co_owner', 'editor', 'viewer')),
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (tree_id, user_id)
);

-- Enable RLS
ALTER TABLE public.tree_members ENABLE ROW LEVEL SECURITY;

-- Tree policies (based on membership)
CREATE POLICY "Tree owners can do everything" 
    ON public.family_trees FOR ALL 
    USING (owner_id = auth.uid());

CREATE POLICY "Tree members can view trees" 
    ON public.family_trees FOR SELECT 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = id AND user_id = auth.uid()
        )
        OR visibility = 'public'
    );

-- Tree members policies
CREATE POLICY "Tree members can view membership" 
    ON public.tree_members FOR SELECT 
    USING (
        user_id = auth.uid() 
        OR EXISTS (
            SELECT 1 FROM public.tree_members tm 
            WHERE tm.tree_id = tree_id AND tm.user_id = auth.uid()
        )
    );

CREATE POLICY "Tree owners can manage members" 
    ON public.tree_members FOR ALL 
    USING (
        EXISTS (
            SELECT 1 FROM public.family_trees 
            WHERE id = tree_id AND owner_id = auth.uid()
        )
    );

-- ============================================
-- PERSONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.persons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tree_id UUID NOT NULL REFERENCES public.family_trees(id) ON DELETE CASCADE,
    created_by UUID NOT NULL REFERENCES public.profiles(id),
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nickname TEXT,
    birth_date DATE,
    death_date DATE,
    is_deceased BOOLEAN NOT NULL DEFAULT FALSE,
    photo_url TEXT,
    additional_photos JSONB DEFAULT '[]'::jsonb,
    bio TEXT,
    location TEXT,
    contact_email TEXT,
    contact_phone TEXT,
    -- Claim & Proxy fields
    claimed_by UUID REFERENCES public.profiles(id),
    claimed_at TIMESTAMPTZ,
    is_claimable BOOLEAN NOT NULL DEFAULT TRUE,
    proxy_managers JSONB DEFAULT '[]'::jsonb,
    proxy_reason TEXT,
    is_elderly_assisted BOOLEAN NOT NULL DEFAULT FALSE,
    -- Privacy
    visibility TEXT NOT NULL DEFAULT 'tree_members' CHECK (visibility IN ('private', 'tree_members', 'public')),
    -- Metadata
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.persons ENABLE ROW LEVEL SECURITY;

-- Persons policies
CREATE POLICY "Tree members can view persons" 
    ON public.persons FOR SELECT 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = persons.tree_id AND user_id = auth.uid()
        )
        OR visibility = 'public'
    );

CREATE POLICY "Tree editors can insert persons" 
    ON public.persons FOR INSERT 
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = persons.tree_id 
            AND user_id = auth.uid() 
            AND role IN ('owner', 'co_owner', 'editor')
        )
    );

CREATE POLICY "Tree editors can update persons" 
    ON public.persons FOR UPDATE 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = persons.tree_id 
            AND user_id = auth.uid() 
            AND role IN ('owner', 'co_owner', 'editor')
        )
    );

CREATE POLICY "Tree owners can delete persons" 
    ON public.persons FOR DELETE 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = persons.tree_id 
            AND user_id = auth.uid() 
            AND role IN ('owner', 'co_owner')
        )
    );

-- ============================================
-- RELATIONSHIPS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS public.relationships (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tree_id UUID NOT NULL REFERENCES public.family_trees(id) ON DELETE CASCADE,
    person1_id UUID NOT NULL REFERENCES public.persons(id) ON DELETE CASCADE,
    person2_id UUID NOT NULL REFERENCES public.persons(id) ON DELETE CASCADE,
    type TEXT NOT NULL CHECK (type IN ('parentChild', 'spouse', 'exSpouse', 'sibling', 'halfSibling', 'stepParent', 'adoptiveParent', 'godparent')),
    start_date DATE,
    end_date DATE,
    created_by UUID NOT NULL REFERENCES public.profiles(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT different_persons CHECK (person1_id != person2_id),
    CONSTRAINT unique_relationship UNIQUE (person1_id, person2_id, type)
);

-- Enable RLS
ALTER TABLE public.relationships ENABLE ROW LEVEL SECURITY;

-- Relationships policies (same as persons)
CREATE POLICY "Tree members can view relationships" 
    ON public.relationships FOR SELECT 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = relationships.tree_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "Tree editors can insert relationships" 
    ON public.relationships FOR INSERT 
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = relationships.tree_id 
            AND user_id = auth.uid() 
            AND role IN ('owner', 'co_owner', 'editor')
        )
    );

CREATE POLICY "Tree editors can update relationships" 
    ON public.relationships FOR UPDATE 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = relationships.tree_id 
            AND user_id = auth.uid() 
            AND role IN ('owner', 'co_owner', 'editor')
        )
    );

CREATE POLICY "Tree owners can delete relationships" 
    ON public.relationships FOR DELETE 
    USING (
        EXISTS (
            SELECT 1 FROM public.tree_members 
            WHERE tree_id = relationships.tree_id 
            AND user_id = auth.uid() 
            AND role IN ('owner', 'co_owner')
        )
    );

-- ============================================
-- INDEXES
-- ============================================
CREATE INDEX IF NOT EXISTS idx_persons_tree_id ON public.persons(tree_id);
CREATE INDEX IF NOT EXISTS idx_relationships_tree_id ON public.relationships(tree_id);
CREATE INDEX IF NOT EXISTS idx_relationships_person1 ON public.relationships(person1_id);
CREATE INDEX IF NOT EXISTS idx_relationships_person2 ON public.relationships(person2_id);
CREATE INDEX IF NOT EXISTS idx_tree_members_user ON public.tree_members(user_id);
CREATE INDEX IF NOT EXISTS idx_tree_members_tree ON public.tree_members(tree_id);

-- ============================================
-- FUNCTIONS & TRIGGERS
-- ============================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_family_trees_updated_at
    BEFORE UPDATE ON public.family_trees
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_persons_updated_at
    BEFORE UPDATE ON public.persons
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Auto-create profile on user signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ============================================
-- REALTIME
-- ============================================
-- Enable realtime for sync
ALTER PUBLICATION supabase_realtime ADD TABLE public.persons;
ALTER PUBLICATION supabase_realtime ADD TABLE public.relationships;
ALTER PUBLICATION supabase_realtime ADD TABLE public.family_trees;
ALTER PUBLICATION supabase_realtime ADD TABLE public.tree_members;

