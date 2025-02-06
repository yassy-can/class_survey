import pandas as pd
from app.LMestimation.shaping import shaping_df
import os
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

# 学習意欲推定
def LMestimation(df):
    keywords =  ["学籍番号","興味","役立","期待","満足","学習意欲"]
    
    #dfの成形
    shaped_df = shaping_df(df, keywords)

    element_score = calculate_element_score(shaped_df)
    loadings = calculate_pca_loadings(shaped_df)

    print("shaped_df:", shaped_df)
    # print("element_score:", element_score)
    print("loadings:", loadings)

    weight = calculate_weight(loadings)

    # print(element_score.iloc[:, 0:3])
    print("weight:", weight)

    element_score_weight = element_score.iloc[:, 0:3].mul(weight.iloc[0], axis=1)
    # print("element_score_wight:", element_score_weight)
    lm = element_score_weight.sum(axis=1)

    # print("lm:\n", type(lm))
    # print("self:\n", type(element_score.iloc[:, 3]))
    
    self_lm = clustering(element_score.iloc[:, 3], False)
    estimated_lm = clustering(lm, True)

    print("estimated_lm:\n", estimated_lm)
    # print("self_lm:\n", self_lm)

    result = pd.concat([shaped_df["学籍番号"], estimated_lm], axis=1)
    result_dict = result.to_dict(orient='records')
    print("result_dict:\n", result_dict)

    return result_dict, loadings

# 要素スコアの算出
def calculate_element_score(df):
    e_score_col = df.iloc[:, 1:5]
    ave = e_score_col.mean()
    std_dev = e_score_col.std()
    
    element_scores = e_score_col.apply(lambda row: row_score(row, ave, std_dev), axis=1)
    element_scores_df = pd.DataFrame(element_scores.tolist(), columns=e_score_col.columns, index=e_score_col.index)

    return element_scores_df

def row_score(row, mean_values, std_values):
    element_score = []
    for rating, mean, std in zip(row, mean_values, std_values):
        if rating >= mean + std:
            element_score.append(1)
        elif rating <= mean - std:
            element_score.append(-1)
        else:
            element_score.append(0)
    return element_score

# 主成分負荷量の算出
def calculate_pca_loadings(df):
    pca_col = df.iloc[:, 1:4]
    # 主成分
    n_components = 1

    # データの標準化
    scaler = StandardScaler()
    df_scaled = scaler.fit_transform(pca_col)
    
    # PCAの実行
    pca = PCA(n_components=n_components)
    pca.fit(df_scaled)
    
    # # 主成分得点（PCAの結果）
    # pca_results = pca.transform(df_scaled)
    
    # # 主成分得点をデータフレームに変換
    # pca_df = pd.DataFrame(pca_results, columns=[f'PCA{i+1}' for i in range(n_components)])
    
    # 主成分負荷量（各主成分に対する特徴量の重み）
    loadings = pd.DataFrame(pca.components_.T, columns=[f'PCA{i+1}' for i in range(n_components)], index=pca_col.columns).T
    
    return loadings

# 重みの算出
def calculate_weight(loadings):
    # データフレーム全体の最小値
    min_value = loadings.values.min()  

    # 最小値を0に置き換え
    loadings = loadings.applymap(lambda x: 0 if x == min_value else x)

    # print("loadings:", loadings)
    ave = loadings.values.mean()
    weight = loadings / ave

    return weight

# 学習意欲を分類
def clustering(motivation, is_estimated):
    classified_column = motivation.apply(
        lambda x: '学習意欲が低い' if x <= -1 else ('学習意欲が高い' if x >= 1 else 'どちらでもない')
    )

    if is_estimated:
        return pd.DataFrame(classified_column, columns=["推定した学習意欲"])
    else:
        return pd.DataFrame(classified_column)

# テスト用
def main():
    # カレントディレクトリを取得
    print("cwd:", os.getcwd())

    input_file = "app/LMestimation/survey.csv"
    df = pd.read_csv(input_file)

    result, loadings = LMestimation(input_file)
    result.to_csv("app/LMestimation/test.csv", index=False, encoding="utf-8")

if __name__ == "__main__":
    main()