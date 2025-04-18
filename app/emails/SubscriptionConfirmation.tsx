import * as React from 'react';

interface EmailTemplateProps {
  username: string;
}

export const SubscriptionConfirmation = ({ username }: EmailTemplateProps) => (
  <div style={{ fontFamily: 'Arial, sans-serif', lineHeight: '1.6' }}>
    <h1 style={{ color: '#4F46E5' }}>Welcome to Lingual Pro, {username}!</h1>
    <p>Your subscription is now active. Here&#39;s what you get:</p>
    <ul>
      <li>✅ Unlimited hearts</li>
      <li>✅ Full access to all courses</li>
      <li>✅ Exclusive learning content</li>
    </ul>
    <p>Start your language learning journey now!</p>
    <a 
      href="https://your-lingual-app.com/learn" 
      style={{
        display: 'inline-block',
        padding: '10px 20px',
        backgroundColor: '#4F46E5',
        color: 'white',
        textDecoration: 'none',
        borderRadius: '5px',
        marginTop: '20px'
      }}
    >
      Start Learning
    </a>
    <p style={{ marginTop: '30px', fontSize: '12px', color: '#666' }}>
      If you didn&#39;t request this subscription, please contact our support team.
    </p>
  </div>
);
