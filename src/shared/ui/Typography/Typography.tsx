import React from 'react';
import { Text, TextProps, TextStyle } from 'react-native';

export const COLORS = {
  primary: '#191F28',
  secondary: '#4E5968',
  tertiary: '#8B95A1',
  quaternary: '#B0B8C1',
  blue: '#3182F6',
  red: '#F04452',
  white: '#FFFFFF',
} as const;

export type TypographyVariant =
  | 'headline'
  | 'title'
  | 'subtitle'
  | 'body'
  | 'callout'
  | 'caption';

export type TypographyColor = keyof typeof COLORS;

export interface TypographyProps extends TextProps {
  variant?: TypographyVariant;
  color?: TypographyColor | string;
  textAlign?: TextStyle['textAlign'];
}

const VARIANT_STYLES: Record<TypographyVariant, TextStyle> = {
  headline: {
    fontSize: 24,
    lineHeight: 34,
    fontWeight: '700',
    fontFamily: 'Pretendard-Bold',
    letterSpacing: -0.5,
  },
  title: {
    fontSize: 20,
    lineHeight: 28,
    fontWeight: '700',
    fontFamily: 'Pretendard-Bold',
    letterSpacing: -0.4,
  },
  subtitle: {
    fontSize: 18,
    lineHeight: 26,
    fontWeight: '600',
    fontFamily: 'Pretendard-SemiBold',
    letterSpacing: -0.3,
  },
  body: {
    fontSize: 16,
    lineHeight: 24,
    fontWeight: '400',
    fontFamily: 'Pretendard-Regular',
    letterSpacing: -0.2,
  },
  callout: {
    fontSize: 14,
    lineHeight: 20,
    fontWeight: '400',
    fontFamily: 'Pretendard-Regular',
    letterSpacing: -0.1,
  },
  caption: {
    fontSize: 13,
    lineHeight: 18,
    fontWeight: '400',
    fontFamily: 'Pretendard-Regular',
    letterSpacing: 0,
  },
};

export const Typography: React.FC<TypographyProps> = ({
  variant = 'body',
  color = 'primary',
  textAlign = 'left',
  style,
  children,
  ...props
}) => {
  const textColor = COLORS[color as TypographyColor] || color;
  const variantStyle = VARIANT_STYLES[variant];

  return (
    <Text
      style={[
        variantStyle,
        { color: textColor, textAlign },
        style,
      ]}
      {...props}
    >
      {children}
    </Text>
  );
};
