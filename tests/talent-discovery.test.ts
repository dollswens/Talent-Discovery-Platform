import { describe, it, expect, beforeEach } from 'vitest';

// Mock contract state
let profiles: any[] = [];
let jobs: any[] = [];
let nextProfileId = 0;
let nextJobId = 0;

// Mock contract functions
function createProfile(sender: string, name: string) {
  const profileId = nextProfileId++;
  profiles[profileId] = { owner: sender, name, skills: [] };
  return profileId;
}

function addSkill(sender: string, profileId: number, skill: string) {
  if (profiles[profileId].owner !== sender) throw new Error('err-unauthorized');
  profiles[profileId].skills.push(skill);
  return true;
}

function createJob(sender: string, title: string, description: string) {
  const jobId = nextJobId++;
  jobs[jobId] = { employer: sender, title, description, requiredSkills: [] };
  return jobId;
}

function addRequiredSkill(sender: string, jobId: number, skill: string) {
  if (jobs[jobId].employer !== sender) throw new Error('err-unauthorized');
  jobs[jobId].requiredSkills.push(skill);
  return true;
}

function getProfile(profileId: number) {
  return profiles[profileId] || null;
}

function getJob(jobId: number) {
  return jobs[jobId] || null;
}

describe('Talent Discovery Platform', () => {
  const user1 = 'user1';
  const user2 = 'user2';
  
  beforeEach(() => {
    profiles = [];
    jobs = [];
    nextProfileId = 0;
    nextJobId = 0;
  });
  
  it('allows users to create profiles', () => {
    const profileId = createProfile(user1, 'Alice');
    expect(profileId).toBe(0);
    
    const profile = getProfile(profileId);
    expect(profile).toEqual({
      owner: user1,
      name: 'Alice',
      skills: [],
    });
  });
  
  it('allows users to add skills to their profiles', () => {
    const profileId = createProfile(user1, 'Bob');
    const result = addSkill(user1, profileId, 'Clarity');
    expect(result).toBe(true);
    
    const profile = getProfile(profileId);
    expect(profile.skills).toEqual(['Clarity']);
  });
  
  it('prevents users from adding skills to other users\' profiles', () => {
    const profileId = createProfile(user1, 'Charlie');
    expect(() => addSkill(user2, profileId, 'Clarity')).toThrow('err-unauthorized');
  });
  
  it('allows users to create jobs', () => {
    const jobId = createJob(user1, 'Clarity Developer', 'We need a Clarity expert');
    expect(jobId).toBe(0);
    
    const job = getJob(jobId);
    expect(job).toEqual({
      employer: user1,
      title: 'Clarity Developer',
      description: 'We need a Clarity expert',
      requiredSkills: [],
    });
  });
  
  it('allows users to add required skills to their jobs', () => {
    const jobId = createJob(user1, 'Clarity Developer', 'We need a Clarity expert');
    const result = addRequiredSkill(user1, jobId, 'Clarity');
    expect(result).toBe(true);
    
    const job = getJob(jobId);
    expect(job.requiredSkills).toEqual(['Clarity']);
  });
  
  it('prevents users from adding required skills to other users\' jobs', () => {
    const jobId = createJob(user1, 'Clarity Developer', 'We need a Clarity expert');
    expect(() => addRequiredSkill(user2, jobId, 'Clarity')).toThrow('err-unauthorized');
  });
  
  it('returns null for non-existent profiles and jobs', () => {
    expect(getProfile(999)).toBeNull();
    expect(getJob(999)).toBeNull();
  });
});

